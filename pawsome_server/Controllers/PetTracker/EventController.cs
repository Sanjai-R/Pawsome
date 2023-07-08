using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using pawsome_server.Data;
using pawsome_server.Dto.Request.PetTracker;
using pawsome_server.Models;
using pawsome_server.Models.Shared;

namespace pawsome_server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EventController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IMapper _mapper;
        public EventController(ApplicationDbContext context, IMapper mapper) {
            _mapper = mapper;
            _context = context;
        }

        // GET: api/Event
        [HttpGet]
        public async Task<ActionResult<IEnumerable<EventModal>>> GetEvents() {
            return await _context.Events.ToListAsync();
        }

        // GET: api/Event/5
        [HttpGet("{id}")]
        public async Task<ActionResult<EventModal>> GetEventModal(int id) {
            var eventModal = await _context.Events.FindAsync(id);

            if(eventModal == null) {
                return NotFound();
            }

            return eventModal;
        }

        [HttpGet("getEventByPet/{id}")]
        public async Task<ActionResult<IEnumerable<EventModal>>> GetEventModelByPetId(int id) {
            var EventModels = await _context.Events.Include(c=>c.Pet)
                .Where(mt => mt.PetId == id)
                .ToListAsync();

            if(EventModels.Count == 0) {
                return new List<EventModal>(); // Return an empty array if no meal trackers are found
            }

            return EventModels;
        }

        // POST: api/Event
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<EventModal>> PostEventModal(AddEventDto eventModal) {
            EventModal temp = _mapper.Map<EventModal>(eventModal);
            try {
                _context.Events.Add(temp);
                await _context.SaveChangesAsync();
            } catch(Exception ex) {
                Console.WriteLine(ex);
                return BadRequest(ex.Message);
            }
            return Ok(temp);
        }


        // PUT: api/Event/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutEventModal(int id, EventModal req) {
            EventModal eventModal = _mapper.Map<EventModal>(req);
            if(id != eventModal.EventId) {
                return BadRequest();
            }
            _context.Entry(eventModal).State = EntityState.Modified;
            try {
                await _context.SaveChangesAsync();
            } catch(DbUpdateConcurrencyException) {
                if(!EventModalExists(id)) {
                    return NotFound();
                }
                else {
                    throw;
                }
            }

            return NoContent();
        }


        // DELETE: api/Event/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteEventModal(int id) {
            var eventModal = await _context.Events.FindAsync(id);
            if(eventModal == null) {
                return NotFound();
            }

            _context.Events.Remove(eventModal);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool EventModalExists(int id) {
            return _context.Events.Any(e => e.EventId == id);
        }
    }
}
