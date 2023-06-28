using System.ComponentModel.DataAnnotations;

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
        }
    }
