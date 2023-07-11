using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace pawsome_server.Models.Shared
{
    public class NotificationModel
    {
        [Key]
        public int NotificationId { get; set; }

        [Required]
        public string NotificationTitle { get; set; }

        [Required]
        public string NotificationBody { get; set; }

        [Required]
        public int UserId { get; set; }

    }
}
