using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Hangfire;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using pawsome_server.Data;
using pawsome_server.Models.PetTracker;

namespace pawsome_server.Controllers.PetTracker
{
    [Route("api/[controller]")]
    [ApiController]
    public class NutrientTrackerController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IBackgroundJobClient _backgroundJobs;
        public NutrientTrackerController(ApplicationDbContext context, IBackgroundJobClient backgroundJobs)
        {
            _context = context;
            _backgroundJobs = backgroundJobs;
        }

        // GET: api/NutrientTracker
        [HttpGet]
        public async Task<ActionResult<IEnumerable<NutrientTrackerModel>>> GetNutrientTracker()
        {
            return await _context.NutrientTracker.ToListAsync();
        }

        // GET: api/NutrientTracker/5
        [HttpGet("{id}")]
        public async Task<ActionResult<NutrientTrackerModel>> GetNutrientTrackerModel(int id)
        {
            var nutrientTrackerModel = await _context.NutrientTracker.FindAsync(id);

            if (nutrientTrackerModel == null)
            {
                return NotFound();
            }

            return nutrientTrackerModel;
        }


        [HttpPut("ResetData")]
        public async Task<IActionResult> ResetAllNutrientTrackerModel()
        {
            Console.WriteLine("Reset Data Job");
            var nutrientTrackerModels = await _context.NutrientTracker.ToListAsync();
            var mealTrackerModels = await _context.MealTracker.ToListAsync();
            foreach (var mealTrackerModel in mealTrackerModels)
            {
                Console.WriteLine(mealTrackerModel.FoodConsumed);
                mealTrackerModel.FoodConsumed = 0;
                _context.Entry(mealTrackerModel).State = EntityState.Modified;
                await _context.SaveChangesAsync();
            }
            foreach (var nutrientTrackerModel in nutrientTrackerModels)
            {
                nutrientTrackerModel.CarbsConsumed = 0;
                nutrientTrackerModel.FatConsumed = 0;
                nutrientTrackerModel.ProteinConsumed = 0;
                _context.Entry(nutrientTrackerModel).State = EntityState.Modified;
                await _context.SaveChangesAsync();
            }
            return Ok();
        }
        // PUT: api/NutrientTracker/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutNutrientTrackerModel(int id, NutrientTrackerModel nutrientTrackerModel)
        {
            if (id != nutrientTrackerModel.NutrientTrackerId)
            {
                return BadRequest();
            }

            _context.Entry(nutrientTrackerModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();

                // Retrieve the associated MealTrackerModel
                var mealTrackerModel = await _context.MealTracker.FirstOrDefaultAsync(mt => mt.NutrientTrackerId == id);

                if (mealTrackerModel != null)
                {
                    // Update the foodConsumed property based on the updated nutrientTrackerModel
                    mealTrackerModel.DailyPlan = nutrientTrackerModel.CarbsPlan + nutrientTrackerModel.ProteinPlan + nutrientTrackerModel.FatPlan;
                    mealTrackerModel.FoodConsumed = nutrientTrackerModel.CarbsConsumed + nutrientTrackerModel.ProteinConsumed + nutrientTrackerModel.FatConsumed;
                    _context.Entry(mealTrackerModel).State = EntityState.Modified;
                    await _context.SaveChangesAsync();
                }
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!NutrientTrackerModelExists(id))
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


        // POST: api/NutrientTracker
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<NutrientTrackerModel>> PostNutrientTrackerModel(NutrientTrackerModel nutrientTrackerModel)
        {
            _context.NutrientTracker.Add(nutrientTrackerModel);

            await _context.SaveChangesAsync();

            return CreatedAtAction("GetNutrientTrackerModel", new { id = nutrientTrackerModel.NutrientTrackerId }, nutrientTrackerModel);
        }

        // DELETE: api/NutrientTracker/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteNutrientTrackerModel(int id)
        {
            var nutrientTrackerModel = await _context.NutrientTracker.FindAsync(id);
            if (nutrientTrackerModel == null)
            {
                return NotFound();
            }

            _context.NutrientTracker.Remove(nutrientTrackerModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool NutrientTrackerModelExists(int id)
        {
            return _context.NutrientTracker.Any(e => e.NutrientTrackerId == id);
        }
    }
}
