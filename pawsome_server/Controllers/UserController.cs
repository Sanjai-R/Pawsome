using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis;
using Microsoft.EntityFrameworkCore;
using pawsome_server.Data;
using pawsome_server.Dto;
using pawsome_server.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;

namespace pawsome_server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public UserController(ApplicationDbContext context)
        {
            _context = context;
        }

        // PUT: api/User/5
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateUser(int id, UserModel userModel)
        {
            try
            {
                if (id != userModel.UserId)
                {
                    return BadRequest();
                }

                _context.Entry(userModel).State = EntityState.Modified;
                await _context.SaveChangesAsync();

                return NoContent();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return BadRequest(ex.Message);
            }
        }

        [HttpPost]
        public async Task<ActionResult<UserModel>> PostUserModel(UserModel userModel)
        {

            var existingUser = _context.Users
                           .Where(x => x.Username == userModel.Username
                           && x.Email == userModel.Email)
                           .FirstOrDefault();

            if (existingUser == null)
            {
                string hashedPassword = HashPassword(userModel.Password);
                userModel.Password = hashedPassword;
                _context.Users.Add(userModel);
                await _context.SaveChangesAsync();

            }
            else
                return Conflict("User already exists");
            return Ok(new
            {
                userId = userModel.UserId,
                username = userModel.Username,
                email = userModel.Email,
                location = userModel.Location,
                mobile = userModel.Mobile,
            });
        }



        [HttpPost("Login")]
        public async Task<ActionResult<UserModel>> LoginUser(LoginDTO data)
        {
            Console.WriteLine("ehevb");
            try
            {
                var userModel = await _context.Users.FirstOrDefaultAsync(u => u.Email == data.Email);

                if (userModel == null)
                {
                    return NotFound("User not found");
                }

                if (!VerifyPassword(data.Password, userModel.Password))
                {
                    return Unauthorized("Invalid password");
                }

                return Ok(new
                {
                    userId = userModel.UserId,
                    username = userModel.Username,
                    email = userModel.Email,
                    location = userModel.Location,
                    mobile = userModel.Mobile,
                });
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return BadRequest(ex.Message);
            }
        }

        // DELETE: api/User/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUser(int id)
        {
            try
            {
                var userModel = await _context.Users.FindAsync(id);

                if (userModel == null)
                {
                    return NotFound();
                }

                _context.Users.Remove(userModel);
                await _context.SaveChangesAsync();

                return NoContent();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return BadRequest(ex.Message);
            }
        }

        private static string HashPassword(string password)
        {
            return BCrypt.Net.BCrypt.HashPassword(password);
        }

        private static bool VerifyPassword(string password, string hashedPassword)
        {
            return BCrypt.Net.BCrypt.Verify(password, hashedPassword);
        }
    }
}
