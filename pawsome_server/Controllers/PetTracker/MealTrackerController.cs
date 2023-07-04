using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using pawsome_server.Data;
using pawsome_server.Models;
using pawsome_server.Models.PetTracker;

namespace pawsome_server.Controllers.PetTracker
{
    [Route("api/[controller]")]
    [ApiController]
    public class MealTrackerController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public MealTrackerController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/MealTracker
        [HttpGet]
        public async Task<ActionResult<IEnumerable<MealTrackerModel>>> GetMealTracker()
        {
            return await _context.MealTracker.Include(c => c.NutrientTracker).ToListAsync();
        }

        // GET: api/MealTracker/5
        [HttpGet("getMealTrackerByPet/{id}")]
        public async Task<ActionResult<MealTrackerModel>> GetMealTrackerModelByPetId(int id)
        {
            var mealTrackerModel = await _context.MealTracker.Include(c => c.NutrientTracker).FirstOrDefaultAsync(mt => mt.PetId == id);

            if (mealTrackerModel == null)
            {
                return NotFound();
            }

            return mealTrackerModel;
        }

        // PUT: api/MealTracker/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutMealTrackerModel(int id, MealTrackerModel mealTrackerModel)
        {
            if (id != mealTrackerModel.MealTrackerId)
            {
                return BadRequest();
            }

            _context.Entry(mealTrackerModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!MealTrackerModelExists(id))
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

        // POST: api/MealTracker
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<MealTrackerModel>> PostMealTrackerModel(MealTrackerModel mealTrackerModel)
        {
            try
            {
                NutrientTrackerModel nutrientTrackerModel = mealTrackerModel.NutrientTracker;
                _context.NutrientTracker.Add(nutrientTrackerModel);
                await _context.SaveChangesAsync();
                Console.WriteLine(nutrientTrackerModel.NutrientTrackerId);
                mealTrackerModel.NutrientTrackerId = nutrientTrackerModel.NutrientTrackerId;
                mealTrackerModel.DailyPlan = nutrientTrackerModel.CarbsPlan + nutrientTrackerModel.ProteinPlan + nutrientTrackerModel.FatPlan;
                mealTrackerModel.FoodConsumed = nutrientTrackerModel.CarbsConsumed + nutrientTrackerModel.ProteinConsumed + nutrientTrackerModel.FatConsumed;
                _context.MealTracker.Add(mealTrackerModel);
                await _context.SaveChangesAsync();
            }
            catch (DbException ex)
            {
                return BadRequest(ex.Message);
            }
            return Ok(mealTrackerModel);

        }

        // DELETE: api/MealTracker/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteMealTrackerModel(int id)
        {
            var mealTrackerModel = await _context.MealTracker.FindAsync(id);
            if (mealTrackerModel == null)
            {
                return NotFound();
            }

            _context.MealTracker.Remove(mealTrackerModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool MealTrackerModelExists(int id)
        {
            return _context.MealTracker.Any(e => e.MealTrackerId == id);
        }
    }
}
