import BrandRepository from "../repositories/brandRepository";
import Brand from "../entities/brand";

class BrandController {

    private _repository: BrandRepository;

    getAll(): Promise<Brand[]> {
        return this._repository.getAll();
    }

    async getById(id: number): Promise<Brand> {
        let brands = await this._repository.getAll()
        return brands.filter(brand => brand.id === id)[0];
    }

}

export default new BrandController();
