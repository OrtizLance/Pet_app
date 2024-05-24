import 'package:flutter/material.dart';

class PetsModel {
  String name;

  String image;
  Color color;
  String description;

  PetsModel({
    required this.image,
    required this.name,
    required this.color,
    required this.description,
  });
}

List<PetsModel> cats = [
  PetsModel(
    name: 'Independent Nature',
   
    image: 'images/cat3.png',
    color: const Color(0xffC1B7B1),
    description:
        "Cats are known for their independence. Unlike dogs, which often require constant attention and companionship, cats are more self-sufficient. They can entertain themselves and don't need as much direct interaction with humans to feel content. This independence is reflected in their behavior, as they often like to explore and find their own cozy spots to nap or observe their surroundings.",
  ),
  PetsModel(
    name: 'Agility and Grace',
   
    image: 'images/cat2.png',
    color: const Color(0xffD7BF9D),
    description:
        "Cats are incredibly agile and graceful creatures. Their bodies are designed for stealth and precision, allowing them to move quietly and quickly. They have excellent balance, thanks to their flexible spines and strong muscles, which makes them adept climbers and jumpers. This agility is often seen when they play, chase after toys, or navigate through tight spaces with ease.",
  ),
  PetsModel(
    name: 'Territorial Behavior',
   
    image: 'images/cat1.png',

    color: const Color(0xffB1D1FF),
    description:
        "Pets bring joy, companionship, and love into our lives. Whether furry, feathered, or scaled, they offer comfort and loyalty. From playful antics to gentle purrs, they teach us patience and responsibility.",
  ),
];

List<PetsModel> dogs = [
  PetsModel(
    name: ' Social and Pack-Oriented',
    
    image: 'images/dog1.png',

    color: const Color(0xffC1B7B1),
    description:
        " Dogs are inherently social animals and have a strong pack mentality. They thrive on companionship and often seek out the company of humans and other dogs. This social nature is a result of their evolutionary history as pack animals, which makes them highly loyal and eager to form bonds. Dogs are known to be affectionate and enjoy participating in family activities, making them excellent companions."),


  PetsModel(
    name: ' Loyalty and Protective Instincts',
    
    image: 'images/dog2.png',

    color: const Color(0xffD7BF9D),
    description:
        "One of the most celebrated characteristics of dogs is their loyalty. Dogs are often fiercely loyal to their owners and will go to great lengths to protect their family. This protective instinct can manifest in behaviors such as barking at strangers or guarding their home. Their loyalty and protective nature make them reliable and devoted pets, often acting as both companions and guardians.",
  ),
  PetsModel(
    name: 'Acute Senses',
    
    image: 'images/dog3.png',

    color: const Color(0xffB1D1FF),
    description:
        "Dogs have highly developed senses, particularly their sense of smell and hearing. A dog's sense of smell is estimated to be thousands of times more sensitive than that of humans, which makes them excellent at tracking scents. Their keen hearing allows them to detect sounds at much higher frequencies and greater distances. These acute senses make dogs valuable in various roles, such as search and rescue, detection of substances, and assisting people with disabilities. Their sensory abilities also enhance their experiences and interactions with the world around them.",
  ),
  PetsModel(
    name: 'Trainability and Intelligence',
   
    image: 'images/dog4.png',

    color: const Color(0xffC1B7B1),
    description:
        " Dogs are highly trainable and intelligent animals. They can learn a wide range of commands and tricks, and many breeds are used in working roles due to their ability to understand and execute complex tasks. This intelligence and trainability stem from their history of working alongside humans in various capacities, such as hunting, herding, and guarding. Positive reinforcement and consistent training can bring out the best in a dog's capabilities, making them versatile and responsive pets.",
  ),
  PetsModel(
    name: ' Playfulness and Energy',
   
    image: 'images/dog5.png',

    color: const Color(0xffB1D1FF),
    description:
        "Dogs are known for their playful and energetic nature. They love engaging in activities that allow them to burn off energy, such as running, fetching, and playing with toys. This playfulness is not only a source of joy for them but also helps them stay physically and mentally healthy. Regular playtime and exercise are essential for a dog's well-being, as they have a natural zest for life and a need to expend their boundless energy.",
  ),
];

List<PetsModel> fish = [
  PetsModel(
    name: ' Tranquil and Relaxing Presence',
   
    image: 'images/1716493263949-fotor-bg-remover-2024052434117.png',

    color: const Color(0xffC1B7B1),
    description:
        "Fish have a tranquil and calming presence, which can be beneficial for reducing stress and anxiety. Watching them swim gracefully in an aquarium can provide a sense of relaxation and peace, making them great companions for relaxation areas or workspaces.",
  ),
  PetsModel(
    name: 'Space Efficiency',
    
    image: 'images/1716493195055-fotor-bg-remover-2024052434012.png',

    color: const Color(0xffC1B7B1),
    description:
        " Fish tanks come in various sizes, making them adaptable to different living spaces. They can be an excellent choice for people with limited space or those living in apartments where traditional pets like dogs or cats may not be feasible.",
  ),
  PetsModel(
    name: 'Low Maintenance',
   
    image: 'images/1716493331868-fotor-bg-remover-2024052434238.png',

    color: const Color(0xffB1D1FF),
    description:
        "Having fish as pets is good because they are generally low maintenance compared to other pets. They don't require daily walks or constant attention, making them ideal for people with busy lifestyles or limited space.",
  ),
];

List<String> categoryList = [
  'Cats',
  'Dogs',
  'Fish',
];