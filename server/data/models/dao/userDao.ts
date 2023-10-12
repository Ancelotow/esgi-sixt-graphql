import User from "../../../domain/entities/user"

class UserDao {
    constructor(
        public id: number,
        public lastname: string,
        public firstname: string,
        public email: string,
        public birthday_date: Date,
        public is_admin: boolean
    ) {}

    toEntity() {
        let user = new User();
        user.id = this.id;
        user.lastname = this.lastname;
        user.firstname = this.firstname;
        user.email = this.email;
        user.birthdayDate = this.birthday_date;
        user.isAdmin = this.is_admin;
        return user;
    }
}
export default UserDao