using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using pawsome_server.Data;
using pawsome_server.Dto.Request.PetTracker;
using pawsome_server.Models;
using pawsome_server.Models.PetManagement;
using pawsome_server.Models.Shared;

namespace pawsome_server.Controllers.PetManagement
{
    [Route("api/[controller]")]
    [ApiController]
    public class AdoptionController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        private readonly IMapper _mapper;
        public AdoptionController(ApplicationDbContext context, IMapper mapper)
        {
            _mapper = mapper;
            _context = context;
        }

        // GET: api/Adoption
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AdoptionModel>>> GetAdoption()
        {
            return await _context.Adoption.Include(c => c.Buyer).
                Include(c => c.Pet).ThenInclude(c => c.User).ToListAsync();
        }

        // GET: api/Adoption/5
        [HttpGet("{id}")]
        public async Task<ActionResult<AdoptionModel>> GetAdoptionModel(int id)
        {
            var adoptionModel = await _context.Adoption.FindAsync(id);

            if (adoptionModel == null)
            {
                return NotFound();
            }

            return adoptionModel;
        }

        // PUT: api/Adoption/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutAdoptionModel(int id, AdoptionModel adoptionModel)
        {
            if (id != adoptionModel.Id)
            {
                return BadRequest();
            }
            NotificationModel notificationModel = new NotificationModel();
            notificationModel.UserId = adoptionModel.BuyerId;
            notificationModel.NotificationBody = $"Your adoption request has been {adoptionModel.Status}";
            notificationModel.NotificationTitle = "Adoption";

            _context.Notifications.Add(notificationModel);

            _context.Entry(adoptionModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AdoptionModelExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Adoption
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<AdoptionModel>> PostAdoptModal(AdoptDto req)
        {
            AdoptionModel adoptionModel = _mapper.Map<AdoptionModel>(req);
            try
            {
                NotificationModel notificationModel = new NotificationModel();
            
                UserModel user = await _context.Users.FindAsync(adoptionModel.BuyerId);
                Pet pet = await _context.Pets.FindAsync(adoptionModel.PetId);
                notificationModel.UserId = pet.UserId;
                notificationModel.NotificationBody = $"Your {pet.Name} has been requested by {user.Username}";
                notificationModel.NotificationTitle = "Adoption";
                
_context.Notifications.Add(notificationModel);
                _context.Adoption.Add(adoptionModel);
                await _context.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                return BadRequest(ex.Message);
            }
            return Ok(adoptionModel);
        }

        // DELETE: api/Adoption/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAdoptionModel(int id)
        {
            var adoptionModel = await _context.Adoption.FindAsync(id);
            if (adoptionModel == null)
            {
                return NotFound();
            }

            _context.Adoption.Remove(adoptionModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool AdoptionModelExists(int id)
        {
            return _context.Adoption.Any(e => e.Id == id);
        }
    }
}
