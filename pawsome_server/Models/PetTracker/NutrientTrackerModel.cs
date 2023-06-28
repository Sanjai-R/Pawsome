using System.ComponentModel.DataAnnotations;

namespace pawsome_server.Models.PetTracker
{
    public class NutrientTrackerModel
    {
        [Key]
        public int NutrientTrackerId { get; set; }

        [Required]
        public int ProteinPlan { get; set; }

        [Required]
        public int ProteinConsumed { get; set; }

        [Required]
        public int FatPlan { get; set; }

        [Required]
        public int FatConsumed { get; set; }

        [Required]
        public int CarbsPlan { get; set; }

        [Required]
        public int CarbsConsumed { get; set; }
    }
}
