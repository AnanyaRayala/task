class DtMailer < ApplicationMailer
  def send_application_status(student_email, r_status, name)
    @status = r_status
    @name =  name
    mail( 
      to: "ananyarayala222@gmail.com",
      subject: "User Request status",
      from: "ananyaswaminathan222@gmail.com"
    )
  end
end
