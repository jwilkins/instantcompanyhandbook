class Handbook < ActiveRecord::Base

  before_create :assign_uuid
  after_commit :generate_pdf

  attr_accessible :name, :logo, :email
  has_attached_file :logo	, :styles => {:pdf_corner => '200x150'}, :default_style => :pdf_corner

  validates :email, :presence => true, :email => true
  validates :name, :presence => true

  # generates an uuid using uuidtools and assigns
  # it to the handbook
  def assign_uuid
    self.id = UUIDTools::UUID.timestamp_create().to_s
  end

  def generate_pdf
    pdf = Prawn::Document.new(
      :page_size => [733, 1000],
      :page_layout => :landscape,
      :left_margin => 0, 
      :right_margin => 0,
      :top_margin => 0,
      :bottom_margin => 0
    )

    pdf.bounding_box [50,633], :width => 900, :height => 533 do
      pdf.bounding_box [0,533], :width => 900, :height => 200 do
        pdf.text(
          "#{name}'s Corporate Handbook", 
          :size => 32, 
          :align => :center, 
          :valign => :center
        )
      end
      pdf.bounding_box [100,333], :width => 700, :height => 333 do
        [ """
        We crated this page because we observed a dangerous lack of structure in the corporate world, particularly in the fragile environment of startup ecosystem.
        """, """
        Startups ignore necessary bureaucracy, their values are only vaguely defined and, henceforth, they are not successful in executing them.
        """, """
        We believe following a set rudimentary rules it necessary to overcome the forthcoming challenges, maintain efforts to deliver top execution, ensure peak performance of the workforce, generate passion, involvement and achievement. Finally, maintain motivation to design and deliver market-leading products and solutions.
        ""","""
        And remember the meta-rule: \"Fake it until you make it!\"
        """ ].each do |paragraph|
          pdf.text paragraph, :align => :left, :size => 16
        end
      end
    end

    Photo.all.sort_by {|p| p.order} .each do |photo|
      pdf.start_new_page
      pdf.image "#{photo.data.path}", :at => [0, 733], :width => 1000, :height =>733 
      if logo.exists?
        pdf.image logo.path, :position => :right, :vposition => :bottom
      end
    end

    p = "public/handbooks/#{id}"
    Dir.mkdir(p) unless File.directory?(p)
    pdf.render_file "#{p}/corporate_handbook.pdf"

    HandbookMailer.availability_notification(self).deliver if email

  end
  handle_asynchronously :generate_pdf

end
