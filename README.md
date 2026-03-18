# SwiftStudentChallenge

This is my App Playground RoadHelper for Swift Student Challenge 26, it was created for people seeking greater safety and knowledge on the road.

RoadHelper began as a way to transform dispersed knowledge into practical, accessible action for everyone — especially in moments of vulnerability on the road. If I can help even one person in one of these situations, or simply make them feel safer and more prepared, it will already have been truly worthwhile for me.

The app centralizes and connects guides for major road emergencies, along with practical knowledge related to them. It answers critical questions such as: “Who should I call?” (since Brazil still does not have a unified emergency number) and “How can I help safely?” One of the guides is based on the PHTLS ( Prehospital Trauma Life Support ) protocol, providing step-by-step guidance on how to assist accident victims.

I was also very interested in finding a way to support these people even without internet access, going beyond the educational aspect. That is how the Attention Assistant emerged, designed to serve as an extra layer of safety by helping drivers maintain focus and vigilance throughout their journey. The system monitors the user’s eyes and issues alerts when signs of drowsiness are detected.

Driven by my interest in exploring Apple’s computer vision frameworks, I developed the Attention Assistant using both frameworks Vision and ARKit. My initial goal was to determine which framework would best support this feature, but testing revealed that each offered complementary strengths in different scenarios.

I found that ARKit, leveraging depth sensors, delivered better performance in low-light environments, though it was directly affected by strong sunlight. In contrast, Vision — which processes image frames without relying on infrared sensors — proved highly resilient under intense sunlight. Rather than choosing one over the other, I implemented both within the app through “Day” (Vision) and “Night” (ARKit) modes, dynamically leveraging each technology to ensure optimal accuracy across varying conditions.

While developing this feature, I quickly realized that the default behavior I had initially designed could fail for users with specific physical characteristics, such as amblyopia, the use of an eye patch, or conditions that affect eye movement synchronization. Recognizing this limitation of the assistant, I created a dedicated Accessibility Mode to ensure it works effectively for these users.
