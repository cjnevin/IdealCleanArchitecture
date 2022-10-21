# IdealCleanArchitecture

AppDelegate

-> LoginCoordinator

  -> LoginViewController
  
    -> LoginPresenter
    
      -> LoginInteractor
      
        -> LoginEntity
        
        -> UserEntity
        
      -> UserCoordinator
      
        -> UserViewController
        
          -> UserPresenter
          
            -> UserInteractor
            
              -> UserEntity
