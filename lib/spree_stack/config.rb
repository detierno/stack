class AprovaFacilStack
  class Config
    def self.user
      @user
    end
  
    def self.user=(user)
      @user = user
    end  
  
    def self.test?
      @test || false
    end
  
    def self.test=(test)
      @test = test
    end  
  end
end