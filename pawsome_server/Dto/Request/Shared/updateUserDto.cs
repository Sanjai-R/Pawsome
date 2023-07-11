using System.ComponentModel.DataAnnotations;

namespace pawsome_server.Dto.Request.Shared
{
    public class updateUserDto
    {
        public int UserId { get; set; }

        public string Mobile { get; set; }

        [Required]
        public string Location { get; set; }

        public string Profile { get; set; }
    }
}
