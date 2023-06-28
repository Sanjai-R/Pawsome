using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace pawsome_server.Dto.Request
{
    public class PetDto
    {
        [Required]
        public string Name { get; set; }

        [Required]
        public string Gender { get; set; }
        [Required]
        public string Breed { get; set; }

        [Required]
        public string Description { get; set; }
        [Required]
        public decimal Price { get; set; }
        [Required]
        public DateTime BirthDate { get; set; }
        [Required]
        public string Image { get; set; }

        [Required]
        public int OwnerId { get; set; }
        [Required]
        public int CategoryId { get; set; }
    }
}
