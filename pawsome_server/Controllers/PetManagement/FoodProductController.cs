using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using pawsome_server.Data;
using pawsome_server.Models.PetManagement;

namespace pawsome_server.Controllers.PetManagement
{
    [Route("api/[controller]")]
    [ApiController]
    public class FoodProductController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public FoodProductController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/FoodProduct
        [HttpGet]
        public async Task<ActionResult<IEnumerable<FoodProduct>>> GetFoodProducts()
        {
            return await _context.FoodProducts.ToListAsync();
        }

        // GET: api/FoodProduct/5
        [HttpGet("{id}")]
        public async Task<ActionResult<FoodProduct>> GetFoodProduct(int id)
        {
            var foodProduct = await _context.FoodProducts.FindAsync(id);

            if (foodProduct == null)
            {
                return NotFound();
            }

            return foodProduct;
        }

        [HttpGet("recommended-foods/{petId}")]
        public async Task<ActionResult<IEnumerable<FoodProduct>>> GetRecommendedFoodProducts(int petId)
        {
            var mealTracker = await _context.MealTracker
                .Include(mt => mt.NutrientTracker)
                .Where(mt => mt.PetId == petId)
                .ToListAsync();

            if (mealTracker.Count == 0)
            {
                var foodProducts = await _context.FoodProducts.ToListAsync();
                return foodProducts;
            }
            else
            {
                Console.WriteLine(JsonConvert.SerializeObject(mealTracker[0].NutrientTracker));
                bool hasSufficientCarbs = mealTracker[0].NutrientTracker.CarbsConsumed < mealTracker[0].NutrientTracker.CarbsPlan;
                bool hasSufficientProtein = mealTracker[0].NutrientTracker.ProteinConsumed < mealTracker[0].NutrientTracker.ProteinPlan;
                bool hasSufficientFat = mealTracker[0].NutrientTracker.FatConsumed < mealTracker[0].NutrientTracker.FatPlan;

                if (hasSufficientCarbs && hasSufficientFat && hasSufficientProtein)
                {
                    return await _context.FoodProducts.ToListAsync();
                }
                else if (hasSufficientCarbs)
                {
                    return await _context.FoodProducts.Where(fp => fp.ContainNutrient != "Carbs").ToListAsync();
                }
                else if (hasSufficientProtein)
                {
                    return await _context.FoodProducts.Where(fp => fp.ContainNutrient != "Proteins").ToListAsync();
                }
                else if (hasSufficientFat)
                {
                    return await _context.FoodProducts.Where(fp => fp.ContainNutrient != "Fats").ToListAsync();
                }
                return null;
            }

        }

        // PUT: api/FoodProduct/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutFoodProduct(int id, FoodProduct foodProduct)
        {
            if (id != foodProduct.Id)
            {
                return BadRequest();
            }

            _context.Entry(foodProduct).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!FoodProductExists(id))
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

        // POST: api/FoodProduct
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<FoodProduct>> PostFoodProduct(FoodProduct foodProduct)
        {
            _context.FoodProducts.Add(foodProduct);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetFoodProduct", new { id = foodProduct.Id }, foodProduct);
        }

        // DELETE: api/FoodProduct/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteFoodProduct(int id)
        {
            var foodProduct = await _context.FoodProducts.FindAsync(id);
            if (foodProduct == null)
            {
                return NotFound();
            }

            _context.FoodProducts.Remove(foodProduct);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool FoodProductExists(int id)
        {
            return _context.FoodProducts.Any(e => e.Id == id);
        }
    }
}
