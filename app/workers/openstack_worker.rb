class OpenstackWorker
  include Sidekiq::Worker
  sidekiq_options queue: :event

  def perform(name)
      puts "#{name}"
  end
end
