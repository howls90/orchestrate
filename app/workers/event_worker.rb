class EventWorker
    include Sidekiq::Worker
    sidekiq_options queue: :event

    def perform(id)
        @event = Event.find(id)
        @event.calulate_rank!
    end
end
