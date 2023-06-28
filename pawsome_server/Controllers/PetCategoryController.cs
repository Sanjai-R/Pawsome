using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using pawsome_server.Data;
using pawsome_server.Models;

namespace pawsome_server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PetCategoryController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public PetCategoryController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/PetCategory
        [HttpGet]
        public async Task<ActionResult<IEnumerable<PetCategory>>> GetPetCategoryModel()
        {
            return await _context.PetCategory.ToListAsync();
        }

        // GET: api/PetCategory/5
        [HttpGet("{id}")]
        public async Task<ActionResult<PetCategory>> GetPetCategory(int id)
        {
            var petCategory = await _context.PetCategory.FindAsync(id);

            if (petCategory == null)
            {
                return NotFound();
            }

            return petCategory;
        }

        // PUT: api/PetCategory/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPetCategory(int id, PetCategory petCategory)
        {
            if (id != petCategory.CategoryId)
            {
                return BadRequest();
            }

            _context.Entry(petCategory).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PetCategoryExists(id))
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

        // POST: api/PetCategory
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<PetCategory>> PostPetCategory(PetCategory petCategory)
        {
            _context.PetCategory.Add(petCategory);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPetCategory", new { id = petCategory.CategoryId }, petCategory);
        }

        // DELETE: api/PetCategory/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePetCategory(int id)
        {
            var petCategory = await _context.PetCategory.FindAsync(id);
            if (petCategory == null)
            {
                return NotFound();
            }

            _context.PetCategory.Remove(petCategory);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool PetCategoryExists(int id)
        {
            return _context.PetCategory.Any(e => e.CategoryId == id);
        }
    }
}
