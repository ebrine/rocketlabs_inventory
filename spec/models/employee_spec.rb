require 'rails_helper'

describe Employee, type: :model do
  let!(:warehouse) { create(:warehouse) }
  let!(:employee) { create(:manager, warehouse: warehouse) }

  describe "validations" do
    it "is invalid when a first name is not entered" do
      employee.first_name = nil
      expect(employee).to be_invalid
    end

    it "is invalid when a last name is not entered" do
      employee.last_name = nil
      expect(employee).to be_invalid
    end

    it "is inavalid when an employee id is not entered" do
      employee.employee_id = nil
      expect(employee).to be_invalid
    end

    it "is valid if manager" do
      expect(employee.is_manager).to eq true
    end

    it "is valid if not a manager" do
      employee.is_manager = false
      expect(employee).to be_valid
    end

    it "invalid if not a manager or employee" do
      employee.is_manager = nil
      expect(employee).to be_invalid
    end

    it "is invalid if employee doesn't have a warehouse id" do
      expect(employee.warehouse_id).to eq warehouse.id
    end
  end

  describe "authenticate method" do
    it "returns employee when password entered is correct" do
      expect(employee.authenticate("password")).to eq Employee.find(employee.id)
    end
    it "returns false when password entered is incorrect" do
      expect(employee.authenticate("something")).to be false
    end
  end

end
