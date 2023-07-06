using System.ComponentModel.DataAnnotations;

namespace pawsome_server.Dto.Request.PetManagement
{
    public class AddBookmarkDto
    {
        [Required]
        public int PetId { get; set; }

        [Required]
        public int UserId { get; set; }
    }
}
