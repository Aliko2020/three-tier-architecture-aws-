import { ArrowRight } from "lucide-react";

export const CategorySection = () => {
  const categories = [
    {
      title: "Laptops",
      image: "/images/laptop.png", 
      link: "/laptops",
    },
    {
      title: "Desktops",
      image: "/images/desktop.png",
      link: "/desktops",
    },
    {
      title: "Accessories",
      image: "/images/accessories.png",
      link: "/accessories",
    },
  ];

  return (
    <section className="py-8 bg-white">
      <div className="max-w-7xl mx-auto px-6 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
        {categories.map(({ title, image, link }) => (
          <div
            key={title}
            className="min-w-[320px] min-h-[360px] relative group border overflow-hidden rounded-lg  hover:shadow-sm transition-shadow duration-300 bg-white"
          >
            <img
              src={image}
              alt={title}
              className="w-full h-64 object-contain bg-white transition-transform duration-300 group-hover:scale-105"
            />

            <div className="absolute top-0 left-0 w-0 h-0 border-t-[120px] border-t-black/10 border-r-[120px] border-r-transparent" />

            <div className="absolute button-5 left-5 mt-2">
              <h3 className="text-lg font-bold text-orange-600 leading-tight">
                {title.split(" ")[0]} <br />
                <span className="text-gray-800">{title.split(" ")[1]}</span>
              </h3>
              <a
                href={link}
                className="mt-2 inline-flex items-center text-sm font-semibold text-orange-600 hover:text-orange-700 transition-colors"
              >
                SHOP<ArrowRight size={14} className="ml-1" />
              </a>
            </div>
          </div>
        ))}
      </div>
    </section>
  );
};
