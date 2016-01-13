class EntriesController < ApplicationController
  def index
    @entry = Entry.new
    @entries = Entry.latest
  end

  def create
    context = CreateEntryContext.new(entry_params, self)
    context.execute
  end

  def show
    @entry = Entry.find(params[:id])

    render
  end

  def destroy
    context = DestroyEntryContext.new(params[:id], self)

    context.execute
  end

  def on_creation_failed!(entry)
    @entry = entry
    @entries = Entry.latest
    render action: :index
  end

  def on_creation_successed!
    redirect_to root_path, notice: 'Message was added successfully.'
  end

  def on_destroing_failed!
    redirect_to root_path, alert: "Wasn't possible to delete the message. Please, try again."
  end

  def on_destroing_successed!
    redirect_to root_path, notice: 'Message was deleted successfully.'
  end

  def on_destroing_failed_gone!
    redirect_to root_path, status: :moved_permanently
  end

private

  def entry_params
    params.require(:entry).permit(:name, :message)
  end
end
