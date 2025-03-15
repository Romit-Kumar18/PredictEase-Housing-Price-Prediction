import Image from "next/image";

export default function Home() {
  return (
    <div className="h-screen border-5 border-solid border-white-500 rounded-2px p-6 bg-[#212121] font-[family-name:var(--font-geist-mono)]">
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
        <div className="flex flex-col place-items-center border-solid border-2 rounded-md p-10">
          <div className="font-bold">
            FIND YOUR PERFECT PROPERTY IN CHENNAI
          </div>
          <div className="mt-2">
            Explore a wide range of properties in Chennai tailored to your preferences.
          </div>
          <div className="mt-5 border-2 border-solid rounded-xl p-10">
            <a 
            href=""
            className="">
              Get Started
            </a>
          </div>
        </div>
      </div>
    </div>
  );
}