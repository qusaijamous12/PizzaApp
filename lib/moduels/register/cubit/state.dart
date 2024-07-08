abstract class RegisterState {}

class InitialRegisterState extends RegisterState{}

class CreateAccountSuccessState extends RegisterState{}

class CreateAccountErrorState extends RegisterState{}

class CreateAccountFireStoreSuccessState extends RegisterState{}

class CreateAccountFireStoreErrorState extends RegisterState{}

class LoadinCreateAccountState extends RegisterState{}