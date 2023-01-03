const TableHeader = (props) => {
  return props.headers.map((head) => {
    return (
      <th scope="col" key={head}>
        {head}
      </th>
    );
  });
};

export default TableHeader;
