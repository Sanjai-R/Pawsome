using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore.Metadata.Internal;

namespace pawsome_server.Models.Shared
{
    public class Pet
    {
        [Key]
        public int PetId { get; set; }
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

        [ForeignKey("UserModel")]
        public int UserId { get; set; }

        [ForeignKey("PetCategoryModel")]
        public int CategoryId { get; set; }
        public PetCategory Category { get; set; }
        public UserModel User { get; set; }
    }
}