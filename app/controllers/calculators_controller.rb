class CalculatorsController < ApplicationController
  before_action :authenticate_user!

  def show
    if params[:id]
      @calculator = Calculator.find_by(id: params[:id])
    else
      @calculator = Calculator.new
    end
  end

  def calculate
    @calculator = current_user.calculators.build(calculator_params)

    height = @calculator.height
    waist = @calculator.waist_line
    neck = @calculator.neck_line
    hip = @calculator.hip || 0

    height_in_cm = height.to_f
    waist = waist.to_f
    neck = neck.to_f
    hip = hip.to_f

    if height_in_cm <= 0 || waist <= 0 || neck <= 0
      @calculator.errors.add(:base, "Please enter valid measurements.")
      render :show and return
    end

  # BMI
  height_in_m = height_in_cm / 100.0
  @calculator.bmi = (@calculator.weight / (height_in_m ** 2)).round(2)

  # Body Fat
  if current_user.gender == "Female"
    if hip <= 0
      @calculator.errors.add(:base, "Please enter valid hip measurement.")
      render :show and return
    end
      body_fat = 495.0 / (1.29579 - 0.35004 * Math.log10(waist + hip - neck) + 0.22100 * Math.log10(height_in_cm)) - 450.0
  else
      body_fat = 495.0 / (1.0324 - 0.19077 * Math.log10(waist - neck) + 0.15456 * Math.log10(height_in_cm)) - 450.0
  end

  @calculator.body_fat = body_fat.round(2)

  if @calculator.save
    flash[:notice] = "Results saved."
  else
    flash[:alert] = "Error recording results."
  end

  render :show
end

def index
  @calculations = current_user.calculators.order(created_at: :desc)
end

private

  def calculator_params
    params.require(:calculator).permit(:weight, :height, :waist_line, :neck_line, :hip, :date)
  end
end
