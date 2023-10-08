import User from "../../domain/entities/user";

class UserDao {
    constructor(
        public id: number,
        public lastname: string,
        public firstname: string,
        public email: string,
        public birthday_date: Date
    ) {}

    toEntity() {
        let user = new User();
        user.id = this.id;
        user.lastname = this.lastname;
        user.firstname = this.firstname;
        user.email = this.email;
        user.birthdayDate = this.birthday_date;
        return user;
    }
}
export default UserDao