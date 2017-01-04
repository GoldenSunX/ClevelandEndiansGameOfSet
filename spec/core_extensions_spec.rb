#Created (Andrew Fox, 9/14): Spec used to test the Core_Extensions class.
#Update (Cole Albers, 9/20): Tersed and Cleaned Up Code.
require 'core_extensions'
String.include CoreExtensions::String

describe String do

  context 'with valid input' do

    it 'should return true when is_nn? is called' do
      test_var = '0'
      expect(test_var.is_nn?).to be true
    end

    it 'should return true when is_nn? is called' do
      test_var = '24'
      expect(test_var.is_nn?).to be true
    end

    it 'should return false when is_nn? is called' do
      test_var = '-21'
      expect(test_var.is_nn?).to be false
    end

    it 'should return false when is_nn? is called' do
      test_var = '1a'
      expect(test_var.is_nn?).to be false
    end

    it 'should return false when is_nn? is called' do
      test_var = '1.1'
      expect(test_var.is_nn?).to be false
    end
  end
end

