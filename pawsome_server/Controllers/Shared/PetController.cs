using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using pawsome_server.Data;
using pawsome_server.Dto.Request;
using pawsome_server.Models.Shared;

namespace pawsome_server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PetController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IMapper _mapper;
        public PetController(ApplicationDbContext context, IMapper mapper) {
            _context = context;
            _mapper = mapper;

        }

        // GET: api/Pet
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Pet>>> GetPetsModel() {
            return await _context.Pets.Include(c => c.Category).Include(c => c.User).ToListAsync();
        }

        // GET: api/Pet/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Pet>> GetPet(int id) {
            var pet = await _context.Pets.FindAsync(id);

            if(pet == null) {
                return NotFound();
            }

            return pet;
        }

        // PUT: api/Pet/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPet(int id, Pet pet) {
            if(id != pet.PetId) {
                return BadRequest();
            }

            _context.Entry(pet).State = EntityState.Modified;

            try {
                await _context.SaveChangesAsync();
            } catch(DbUpdateConcurrencyException) {
                if(!PetExists(id)) {
                    return NotFound();
                }
                else {
                    throw;
                }
            }

            return NoContent();
        }


        [HttpPost]
        public async Task<ActionResult<Pet>> PostPet(PetDto req) {

            Pet pet = _mapper.Map<Pet>(req);

            _context.Pets.Add(pet);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPet", new { id = pet.PetId }, pet);
        }

        // DELETE: api/Pet/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePet(int id) {
            var pet = await _context.Pets.FindAsync(id);
            if(pet == null) {
                return NotFound();
            }

            _context.Pets.Remove(pet);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool PetExists(int id) {
            return _context.Pets.Any(e => e.PetId == id);
        }
    }
}
