export interface TeamMember {
  name: string;
  role: string;
  description?: string;
  quote?: string;
  photo?: string;
  email?: string;
  phone?: string;
  links?: { label: string; url: string }[];
}

export const TEAM: TeamMember[] = [
  {
    name: 'Ailin Cruz Crisóstomo',
    role: 'Catalizadora de ideas · Estratega de innovación',
    description:
      'Transformo ideas en propuestas, conecto la innovación con necesidades reales y comunico soluciones capaces de generar impacto.',
    quote: '¿Quién dijo que eres muy joven?',
    photo: '/team/ailin.jpg',
    email: 'ailincruz015@gmail.com',
    phone: '+1 829-993-3630',
    links: [],
  },
  {
    name: 'Darlyng Rafael Mateo Peral',
    role: 'Desarrollador de software · Analista de sistemas',
    description:
      'Transformo ideas en algo visual, hago que la imaginación deje de ser un sueño y se convierta en una realidad.',
    quote: 'La vida es muy corta como para no vivirla.',
    photo: '/team/yomismo.jpg',
    email: 'mateodarlyng5@gmail.com',
    phone: '+1 829-876-0411',
    links: [],
  },
];
