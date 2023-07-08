using AutoMapper;
using pawsome_server.Dto.Request.PetManagement;
using pawsome_server.Dto.Request.PetTracker;
using pawsome_server.Models.PetManagement;


namespace pawsome_server.Profiles.PetTracker
{
    public class BookMarkProfile : Profile
    {
        public BookMarkProfile()
        {
            CreateMap<AddBookmarkDto, BookMarkModel>();
        }
    }
}
