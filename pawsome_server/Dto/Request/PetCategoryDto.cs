using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace pawsome_server.Dto.Request
{
    public class PostPetCategoryDto
    {
        [Required]
        public string CategoryName { get; set; }
        public string CategoryDescription { get; set; }
    }
    
}
