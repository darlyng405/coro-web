export interface SDG {
  number: number;
  name: string;
  description: string;
  color: string;
  image: string;
}

export const SDGS: SDG[] = [
  {
    number: 10,
    name: 'Reducción de las desigualdades',
    description:
      'Damos voz a comunidades que normalmente no son escuchadas y reducimos la brecha entre jóvenes y las instituciones.',
    color: '#DD1367',
    image: '/sdgs/ods-10.png',
  },
  {
    number: 11,
    name: 'Ciudades y comunidades sostenibles',
    description:
      'Mejoramos los espacios públicos del barrio reportando y resolviendo problemas reales con evidencia verificable.',
    color: '#FD9D24',
    image: '/sdgs/ods-11.png',
  },
  {
    number: 16,
    name: 'Paz, justicia e instituciones sólidas',
    description:
      'Construimos transparencia: cada caso tiene seguimiento público y cada institución responde con datos.',
    color: '#00689D',
    image: '/sdgs/ods-16.png',
  },
  {
    number: 17,
    name: 'Alianzas para lograr los objetivos',
    description:
      'Conectamos jóvenes, comunidades y organizaciones verificadas para multiplicar el impacto colectivo.',
    color: '#19486A',
    image: '/sdgs/ods-17.png',
  },
];
