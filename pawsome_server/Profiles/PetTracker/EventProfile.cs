using AutoMapper;
using pawsome_server.Dto.Request.PetTracker;
using pawsome_server.Dto.Request.Shared;
using pawsome_server.Models;
using pawsome_server.Models.Shared;

namespace pawsome_server.Profiles.PetTracker
{
    public class EventProfile : Profile
    {
        public EventProfile() {
            CreateMap<AddEventDto, EventModal>();
            
        }
    }
}
