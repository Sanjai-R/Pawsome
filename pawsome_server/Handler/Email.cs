using System.Net.Mail;
using System.Net;

namespace pawsome_server.Handler
{
    public class Email
    {
        public static void SendEmail(string body, string subject, string email)
        {
            Console.WriteLine("Sent command triggered");
            var client = new SmtpClient("sandbox.smtp.mailtrap.io", 2525)
            {
                Credentials = new NetworkCredential("250a1a4966942e", "68c5410b07d0cf"),
                EnableSsl = true
            };
            using (MailMessage mail = new())
            {
                mail.From = new MailAddress("from@example.com");
                mail.To.Add(email);
                mail.Subject = subject;
                mail.Body = body;
                client.Send(mail);
            }

            Console.WriteLine("Sent");
        }
    }
}
