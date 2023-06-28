using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace pawsome_server.Models
    {
    public class MealTrackerModel
        {
        [Key]
        public int MealTrackerId { get; set; }

        [Required]
        public int DailyPlan { get; set; }

        [Required]
        public int FoodConsumed { get; set; }

        [ForeignKey("NutrientTracker")]
        public int NutrientTrackerId { get; set; }

        public virtual NutrientTrackerModel NutrientTracker { get; set; }
        }
    }
