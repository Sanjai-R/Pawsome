using System.ComponentModel.DataAnnotations;

namespace pawsome_server.Dto.Request.PetTracker
{
    public class AdoptDto
    {

        [Required]
        public int PetId { get; set; }

        [Required]
        public int BuyerId { get; set; }

        [Required]
        public string Status { get; set; }

        [Required]
        public DateTime Date { get; set; }


    }
}
