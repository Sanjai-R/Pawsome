using System.ComponentModel.DataAnnotations;

namespace pawsome_server.Dto.Request.PetTracker
{
    public class AddEventDto
    {

        [Required]
        public int PetId { get; set; }
        [Required]
        public DateTime EventDateTime { get; set; }
        [Required]
        public string EventTitle { get; set; }
        [Required]
        public string EventDesc { get; set; }
        [Required]
        public bool HasReminder { get; set; }
    }
}
