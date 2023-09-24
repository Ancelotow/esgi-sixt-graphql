import BrandRepository from "../repositories/brandRepository";
import Brand from "../entities/brand";
import BrandDbRepository from "../../data/repositories/database/brandDbRepository";

class BrandController {

    private _repository: BrandRepository = new BrandDbRepository();

    getAll(): Promise<Array<Brand>> {
        return this._repository.getAll();
    }

    async getById(id: number): Promise<Brand> {
        let brands = await this._repository.getAll()
        return brands.filter(brand => brand.id === id)[0];
    }

}

export default new BrandController();
