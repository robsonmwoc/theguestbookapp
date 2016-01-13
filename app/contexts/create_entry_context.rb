class CreateEntryContext
  def initialize(params, listener)
    @listener = listener
    @entry = Entry.new(params)
  end

  def execute
    return @listener.on_creation_successed! if @entry.valid? && @entry.save
    @listener.on_creation_failed!(@entry)
  end
end
