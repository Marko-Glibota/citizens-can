class LawsController < ApplicationController
  before_action :set_law, only: [:show, :upvote, :downvote, :for, :against]
  before_action :authenticate_user!, only: [:upvote, :downvote]
  skip_before_action :authenticate_user!, only: [:index, :show]
  # Pagy
  include Pagy::Backend

  def index
    @laws = Law.order(date: :desc)

    if params[:query].present?
      @laws = @laws.where("title ILIKE ?", "%#{params[:query]}%")
    end

    @pagy, @laws = pagy(@laws, items: 10)

    @most_upvoted_laws = Law.order(:cached_votes_up => :desc).first(10)
    @most_downvoted_laws = Law.order(:cached_votes_down => :desc).first(10)

    @img_array = []
    @img_array << "https://static.lpnt.fr/images/2020/03/09/20136479lpw-20136932-article-lrem-coronavirus-epidemie-jpg_6963903_660x281.jpg"
    @img_array << "https://www.actu-environnement.com/images/illustrations/breve/35166_large.jpg"
    @img_array << "https://media-exp1.licdn.com/dms/image/C4E1BAQGhVbo2nGUTVg/company-background_10000/0/1549039117898?e=2159024400&v=beta&t=tazZDKI3DRVKY_LGXDDWr5ASCL5CwbACjDw6mfispUo"
    @img_array << "https://img.20mn.fr/yJRDt54zRViCXAYNXb0J6w/814x360_assemblee-nationale-illustration.jpg"
    @img_array << "https://cdn-lejdd.lanmedia.fr/var/europe1/storage/images/lejdd/politique/assemblee-nationale-7-choses-a-savoir-sur-le-fauteuil-de-president-3749012/50000393-1-fre-FR/Assemblee-nationale-7-choses-a-savoir-sur-le-fauteuil-de-president.jpg"
    @img_array << "https://www2.assemblee-nationale.fr/var/ezflow_site/storage/images/media/patrimoine/palais-bourbon/bibliotheque-le-plafond/6690-4-fre-FR/bibliotheque-le-plafond.jpg"
    @img_array << "https://www.touteleurope.eu/fileadmin/_TLEv3/emploi_social/AN_dumping.jpg"
    @img_array << "https://www2.assemblee-nationale.fr/var/ezflow_site/storage/images/media/travail-parlementaire/une-seance-dans-l-hemicycle-de-l-assemblee-nationale/345237-1-fre-FR/une-seance-dans-l-hemicycle-de-l-assemblee-nationale.jpg"
  end

  def show
    @comment = Comment.new
    @upvote_count = @law.get_upvotes.size
    @downvote_count = @law.get_downvotes.size
  end

  def for
    @law.upvote_from current_user
    @upvote_count = @law.get_upvotes.size
    @downvote_count = @law.get_downvotes.size
  end

  def against
    @law.downvote_from current_user
    @upvote_count = @law.get_upvotes.size
    @downvote_count = @law.get_downvotes.size
  end

  private

  def set_law
    @law = Law.find(params[:id])
  end
end
