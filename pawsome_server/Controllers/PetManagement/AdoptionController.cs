
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using pawsome_server.Data;
using pawsome_server.Models;
using pawsome_server.Models.PetTracker;
using pawsome_server.Models.PetManagement;
using AutoMapper;
using pawsome_server.Dto.Request.PetTracker;

namespace pawsome_server.Controllers.PetManagement
{
    [Route("api/[controller]")]
    [ApiController]
    class AdoptionController:ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IMapper _mapper;
        public AdoptionController(ApplicationDbContext context, IMapper mapper) {
            _mapper = mapper;
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<AdoptionModel>>> GetEvents()
        {
            return await _context.Adoption.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<AdoptionModel>> GetEventModal(int id)
        {
            var eventModal = await _context.Adoption.FindAsync(id);

            if (eventModal == null)
            {
                return NotFound();
            }

            return eventModal;
        }
        // POST: api/Event
        [HttpPost]
        public async Task<ActionResult<AdoptionModel>> PostEventModal(AdoptDto req)
        {
            AdoptionModel adoptionModel = _mapper.Map<AdoptionModel>(req);
            try
            {
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

        [HttpPut("{id}")]

        public async Task<IActionResult> UpdateAdoptModal(int id, AdoptionModel req)
        {
            AdoptionModel adoptionModel = _mapper.Map<AdoptionModel>(req);
            if (id != adoptionModel.Id)
            {
                return BadRequest();
            }

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

            return Ok(adoptionModel);
        }

        private bool AdoptionModelExists(int id)
        {
            return _context.Adoption.Any(e => e.Id == id);
        }
    } 
}