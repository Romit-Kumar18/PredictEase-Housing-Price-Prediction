import Image from "next/image";

export default function Home() {
  return (
    <div className="h-max p-6 bg-[#212121] font-[family-name:var(--font-geist-mono)]">
      <div className="flex flex-col items-center font-[family-name:var(--font-geist-sans)] text-[#ffffff] text-4xl --drop-shadow-xl font-bold">
        <span>
          Welcome to <span className="text-[#ff9900]">PredictEase</span>
        </span>
      </div>
      <div className="flex justify-center items-center w-full">
        <Image
          className="m-10"
          src="/JL5.jpg"
          alt="intro"
          width={850}
          height={600}
        />
      </div>
      <div className="bg-[#313131]">
        <div className="flex flex-col items-center justify-center border-solid border-2 rounded-md pt-10">
          <div className="font-bold text-xl">
            GET AN ACCURATE ESTIMATE OF HOUSE PRICES IN CHENNAI
          </div>
          <div className="mt-2 max-w-xl text-center">
            Get house price estimates in Chennai using data-driven analytics. Ideal for buyers, sellers, and investors.</div>
          <a href="/prediction" className="group m-5 border-2 border-solid border-white rounded-xl p-5 transition duration-300 ease-in-out bg-orange-600 hover:bg-blue-600 hover:scale-105">
            <div>
              <p>Get Started</p>
            </div>
          </a>
        </div>
      </div>
    </div>
  );
}