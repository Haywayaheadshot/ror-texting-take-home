class SendMessagesController < ApplicationController
  before_action :set_send_message, only: %i[show edit update destroy]

  # GET /send_messages or /send_messages.json
  def index
    @send_messages = SendMessage.all
  end

  # GET /send_messages/1 or /send_messages/1.json
  def show; end

  # GET /send_messages/new
  def new
    @send_message = SendMessage.new
  end

  # GET /send_messages/1/edit
  def edit; end

  # POST /send_messages or /send_messages.json
  def create
    @send_message = SendMessage.new(send_message_params)

    respond_to do |format|
      if @send_message.save
        format.html { redirect_to send_message_url(@send_message), notice: 'Send message was successfully created.' }
        format.json { render :show, status: :created, location: @send_message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @send_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /send_messages/1 or /send_messages/1.json
  def update
    respond_to do |format|
      if @send_message.update(send_message_params)
        format.html { redirect_to send_message_url(@send_message), notice: 'Send message was successfully updated.' }
        format.json { render :show, status: :ok, location: @send_message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @send_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /send_messages/1 or /send_messages/1.json
  def destroy
    @send_message.destroy

    respond_to do |format|
      format.html { redirect_to send_messages_url, notice: 'Send message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_send_message
    @send_message = SendMessage.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def send_message_params
    params.fetch(:send_message, {})
  end
end
