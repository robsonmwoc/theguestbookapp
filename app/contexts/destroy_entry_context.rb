class DestroyEntryContext
  def initialize(entry_id, listener)
    @listener = listener
    @entry = Entry.find(entry_id)
  rescue ActiveRecord::RecordNotFound
    @entry = nil
  end

  def execute
    return entry_does_not_exists_error if @entry.nil?

    if @entry.destroy
      @listener.on_destroing_successed!
    else
      @listener.on_destroing_failed!
    end
  end

private

  def entry_does_not_exists_error
    @listener.on_destroing_failed_gone!
  end
end
