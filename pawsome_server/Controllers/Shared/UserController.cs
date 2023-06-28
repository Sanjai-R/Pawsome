using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using pawsome_server.Data;
using pawsome_server.Dto.Request;
using pawsome_server.Handler;
using pawsome_server.Models;
using pawsome_server.Service;
using StackExchange.Redis;

namespace pawsome_server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IDatabase _cacheDb;
        public UserController(ApplicationDbContext context, IConnectionMultiplexer connectionMultiplexer) {
            _context = context;
            _cacheDb = connectionMultiplexer.GetDatabase();
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<UserModel>>> GetUsers() {
            return await _context.Users.ToListAsync();
        }

        // PUT: api/User/5
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateUser(int id, UserModel userModel) {
            try {
                if(id != userModel.UserId) {
                    return BadRequest();
                }

                _context.Entry(userModel).State = EntityState.Modified;
                await _context.SaveChangesAsync();

                return NoContent();
            } catch(Exception ex) {
                Console.WriteLine(ex.Message);
                return BadRequest(ex.Message);
            }
        }

        [HttpPost]
        public async Task<ActionResult<UserModel>> PostUserModel(UserModel userModel) {

            var existingUser = _context.Users
                           .Where(x => x.Username == userModel.Username
                           && x.Email == userModel.Email)
                           .FirstOrDefault();

            if(existingUser == null) {
                string hashedPassword = HashPassword(userModel.Password);
                userModel.Password = hashedPassword;
                _context.Users.Add(userModel);
                await _context.SaveChangesAsync();

            }
            else
                return Conflict("User already exists");
            return Ok(new {
                userId = userModel.UserId,
                username = userModel.Username,
                email = userModel.Email,
                location = userModel.Location,
                mobile = userModel.Mobile,
            });
        }



        [HttpPost("Login")]
        public async Task<ActionResult<UserModel>> LoginUser(LoginDTO data) {
            try {
                var userModel = await _context.Users.FirstOrDefaultAsync(u => u.Email == data.Email);

                if(userModel == null) {
                    return NotFound("User not found");
                }

                if(!VerifyPassword(data.Password, userModel.Password)) {
                    return Unauthorized("Invalid password");
                }

                return Ok(new {
                    userId = userModel.UserId,
                    username = userModel.Username,
                    email = userModel.Email,
                    location = userModel.Location,
                    mobile = userModel.Mobile,
                });
            } catch(Exception ex) {
                Console.WriteLine(ex.Message);
                return BadRequest(ex.Message);
            }
        }

        // DELETE: api/User/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUser(int id) {
            try {
                var userModel = await _context.Users.FindAsync(id);

                if(userModel == null) {
                    return NotFound();
                }

                _context.Users.Remove(userModel);
                await _context.SaveChangesAsync();

                return NoContent();
            } catch(Exception ex) {
                Console.WriteLine(ex.Message);
                return BadRequest(ex.Message);
            }
        }


        [HttpGet("SendOtp/email={email}")]
        public async Task<IActionResult> SendOtp(string email) {

            try {
                var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == email);
                if(user == null) {
                    // User not found, handle error
                    return BadRequest("Invalid Email");
                }
                // Generate OTP
                string otp = GenerateOTP();
                await _cacheDb.StringSetAsync(email, otp);
                var message = $"YOUR OTP {otp}";
                Email.SendEmail(message, "RESET PASSWORD OTP", email);
                return Ok(new { status = true, message = "OTP has been sent to your email for password reset." });
            } catch(Exception ex) {
                Console.WriteLine(ex.Message);
                return BadRequest(new { status = false, message = "OTP has been sent to your email for password reset." });
            }

        }

        [HttpGet("VerifyOtp/otp={otp}/email={email}")]
        public async Task<IActionResult> VerifyOtp(string otp, string email) {
            Console.WriteLine($"CLIENt {otp}");
            string dbOtp = await _cacheDb.StringGetAsync(email);

            Console.WriteLine($"DB {dbOtp}");

            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == email);

            if(user == null) {

                // User not found, handle error
                return BadRequest("Invalid Email");
            }
            if(dbOtp == otp) {
                await _cacheDb.KeyDeleteAsync(email);
                return Ok(new { status = true, message = "OTP has been verified." });

            }
            else
                return BadRequest("Invalid OTP");

        }

        [HttpPut("ResetPassword")]
        public async Task<IActionResult> ResetPassword(LoginDTO user) {
            Console.WriteLine(user.Email);
            // Retrieve user by email
            var users = await _context.Users.FirstOrDefaultAsync(u => u.Email == user.Email);
            if(users == null) {
                // User not found, handle error
                return BadRequest("Invalid Email");
            }

            // Update user's password
            users.Password = BCrypt.Net.BCrypt.HashPassword(user.Password);
            _context.SaveChanges();

            // Return success response
            return Ok(new { status = true, message = "Password has been reset successfully." });



        }
        private string GenerateOTP() {
            // Generate a 6-digit OTP
            Random random = new Random();
            int otp = random.Next(10000, 99999);
            return otp.ToString();
        }
        private static string HashPassword(string password) {
            return BCrypt.Net.BCrypt.HashPassword(password);
        }

        private static bool VerifyPassword(string password, string hashedPassword) {
            return BCrypt.Net.BCrypt.Verify(password, hashedPassword);
        }
    }
}
