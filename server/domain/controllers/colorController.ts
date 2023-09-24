import ColorRepository from "../repositories/colorRepository";
import Color from "../entities/color";
import ColorDbRepository from "../../data/repositories/database/colorDbRepository";

class ColorController {

    private _repository: ColorRepository = new ColorDbRepository();

    getAll(): Promise<Color[]> {
        return this._repository.getAll();
    }

    async getById(id: number): Promise<Color> {
        let colors = await this._repository.getAll()
        return colors.filter(color => color.id === id)[0];
    }

}

export default new ColorController();
