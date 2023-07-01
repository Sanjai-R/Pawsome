using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace pawsome_server.Models
    {
    public class WalkingTrackerModel
        {
        [Key]
        public int WalkingTrackerId { get; set; }

        [Required]
        public int WalkingGoalMinutes { get; set; }

        [Required]
        public int MinutesCovered { get; set; }

        [ForeignKey("Pets")]
        public int PetId { get; set; }
    }
    }
