

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using pawsome_server.Models.Shared;

namespace pawsome_server.Models
{
    public class EventModal
        {
        [Key]
        public int EventId { get; set; }
        [Required]
        [ForeignKey("Pets")]
        public int PetId { get; set; }
        [Required]
        public DateTime EventDateTime { get; set; }
        [Required]
        public string EventTitle { get; set; }

        [Required]
        public string EventDesc { get; set; }
        [Required]
        public bool HasReminder { get; set; }

        // Navigation property for the related Pet entity
        public virtual Pet Pet { get; set; }
        }
    }
