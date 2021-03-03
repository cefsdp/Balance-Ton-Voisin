class VotesController < ApplicationController
  def create
    @vote = Vote.new
    authorize @vote
    @vote.clash = Clash.find(params[:clash_id])
    @vote.user = current_user
    @vote.party = params[:party]
    if @vote.save!
      respond_to do |format|
        format.html { redirect_to publication_path(@vote.clash.clash_request.publication)}
        format.json { render json: { success: true, counter: @vote.clash.votes.where(party: params[:party]).count, voteId: @vote.id } }
      end
    else
      respond_to do |format|
        format.html { render publication_path(@vote.clash.clash_request.publication)}
        format.json { render json: { success: false } }
      end
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    authorize @vote
    if @vote.destroy!
      respond_to do |format|
        format.html { redirect_to publication_path(@vote.clash.clash_request.publication)}
        format.json { render json: { success: true, counter: @vote.clash.votes.where(party: params[:party]).count } }
      end
    else
      respond_to do |format|
        format.html { render publication_path(@vote.clash.clash_request.publication)}
        format.json { render json: { success: false } }
      end
    end
  end
end
