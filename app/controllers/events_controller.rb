class EventController
    def ranking
        EventWorker.perform_in 1.minute @event.id
    end
end
